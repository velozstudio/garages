import { type TGarage, type TVehicle, fetchData } from "../utils";
import Progress from "./ui/Progress";

interface SelectedVehicleProps {
  vehicle: TVehicle;
  garage: TGarage;
}

const SelectedVehicle = ({ vehicle, garage }: SelectedVehicleProps) => {
  return (
    <div className="w-full max-w-[15rem] space-y-1 rounded bg-veloz-neutral-700/50 p-1">
      <div className="flex h-full w-full flex-col justify-between">
        <div className="space-y-8">
          <h1 className="mt-1 text-center text-xl font-bold capitalize">{vehicle.name.toLowerCase()}</h1>
          <VehicleStats vehicle={vehicle} garage={garage} />
        </div>
        <VehicleOptions vehicle={vehicle} garage={garage} />
      </div>
    </div>
  );
};

const VehicleStats = ({ vehicle }: SelectedVehicleProps) => {
  return (
    <div className="space-y-4 px-2">
      <div className="space-y-1">
        <h1 className="text-xs opacity-80">Fuel</h1>
        {vehicle.stats && <Progress value={vehicle.stats.fuel ? vehicle.stats.fuel : NaN} />}
      </div>

      <div className="space-y-1">
        <h1 className="text-xs opacity-80">Body</h1>
        {vehicle.stats && <Progress value={Number(((vehicle.stats.body / 1000) * 100).toFixed(0))} />}
      </div>

      <div className="space-y-1">
        <h1 className="text-xs opacity-80">Engine</h1>
        {vehicle.stats && <Progress value={Number(((vehicle.stats.engine / 1000) * 100).toFixed(0))} />}
      </div>
    </div>
  );
};

const VehicleOptions = ({ vehicle, garage }: SelectedVehicleProps) => {
  return (
    <div>
      {vehicle.state === 1 && garage.id === vehicle.garageId && (
        <div
          className="cursor-pointer rounded bg-veloz-primary/25 p-2 text-center text-sm hover:bg-veloz-primary"
          onClick={() => {
            fetchData("selectVehicle", { vehicle, garage });
          }}
        >
          Drive
        </div>
      )}

      {vehicle.state === 0 && <div className="rounded border border-red-500/25 p-2 text-center text-sm text-red-500">Outside</div>}

      {vehicle.state === 1 && garage.id !== vehicle.garageId && (
        <div
          className="cursor-pointer rounded bg-veloz-primary/25 p-2 text-center text-sm hover:bg-veloz-primary"
          onClick={() => {
            fetchData("transferVehicle", { vehicle, garage });
          }}
        >
          Transfer to {garage.label}
        </div>
      )}

      {vehicle.state === 2 && garage.impound && (
        <div
          className="cursor-pointer rounded bg-veloz-primary/25 p-2 text-center text-sm hover:bg-veloz-primary"
          onClick={() => {
            fetchData("unimpoundVehicle", { vehicle, garage });
          }}
        >
          Retrieve
        </div>
      )}

      {vehicle.state === 2 && !garage.impound && (
        <div
          className="cursor-pointer rounded bg-veloz-primary/25 p-2 text-center text-sm hover:bg-veloz-primary"
          onClick={() => {
            fetchData("pinImpound", { garage: vehicle.garageId });
          }}
        >
          Set Waypoint
        </div>
      )}
    </div>
  );
};

export default SelectedVehicle;
