import { useEffect, useState } from "react";
import { useEventListener } from "usehooks-ts";
import { TGarage, TVehicle, fetchData } from "./utils";
import Vehicles from "./components/Vehicles";
import SelectedVehicle from "./components/SelectedVehicle";
import Garages from "./components/Garages";

interface SelectedGarage extends TGarage {
  vehicles?: TVehicle[];
}

const App = () => {
  const [display, setDisplay] = useState(true);
  const [garages, setGarages] = useState<TGarage[]>();
  const [currentGarageId, setCurrentGarageId] = useState<string>();
  const [vehicles, setVehicles] = useState<TVehicle[]>();
  const [selectedVehicle, setSelectedVehicle] = useState<TVehicle | null>();
  const [selectedGarage, setSelectedGarage] = useState<SelectedGarage>();

  useEventListener("message", (event: MessageEvent) => {
    const { action, payload } = event.data;

    if (action === "setGarageDisplay") {
      setDisplay(payload.display);
    }

    if (action === "setGarageData") {
      setGarages(payload.garages);
      setCurrentGarageId(payload.currentGarageId);
      setVehicles(payload.vehicles);
    }
  });

  useEventListener("keydown", (event: KeyboardEvent) => {
    if (["Escape"].includes(event.code)) {
      if (display) fetchData("closeGarageDisplay");
    }
  });

  useEffect(() => {
    if (garages && currentGarageId) {
      const defaultGarage = garages.find((garage) => garage.id === currentGarageId);
      setSelectedGarage(defaultGarage || garages[0]);
    }
  }, [garages, currentGarageId]);

  useEffect(() => {
    setSelectedVehicle(null);
  }, [display, vehicles, selectedGarage]);

  if (!display || !garages || !currentGarageId || !vehicles || !selectedGarage) return null;

  const filteredVehicles = vehicles.filter((vehicle) => vehicle.garageId === selectedGarage.id);

  return (
    <div className="flex h-screen w-screen items-center justify-center">
      <div className="flex h-[46rem] w-[80rem] select-none gap-1 overflow-hidden rounded-lg bg-veloz-neutral-900 p-1 text-veloz-white">
        <Garages
          garages={garages}
          vehicles={vehicles}
          currentGarageId={currentGarageId}
          currentSelectedGarageId={selectedGarage.id}
          onSelectedGarage={setSelectedGarage}
        />

        <div className="w-full space-y-1 rounded">
          {filteredVehicles.length > 0 ? (
            <Vehicles vehicles={filteredVehicles} selectedVehicle={selectedVehicle} onSelectVehicle={setSelectedVehicle} />
          ) : (
            <div className="flex h-full items-center justify-center">
              <div className="p-2 text-xl">This Garage Is Empty!</div>
            </div>
          )}
        </div>

        {selectedVehicle ? (
          <SelectedVehicle garage={garages.find((garage) => garage.id === currentGarageId) as TGarage} vehicle={selectedVehicle} />
        ) : null}
      </div>
    </div>
  );
};

export default App;
