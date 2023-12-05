import { type TVehicle, cn } from "../utils";

interface VehiclesProps {
  vehicles: TVehicle[];
  selectedVehicle: TVehicle | undefined | null;
  onSelectVehicle: (vehicle: TVehicle) => void;
}

const Vehicles = ({ vehicles, selectedVehicle, onSelectVehicle }: VehiclesProps) => {
  const sortedVehicles = [...vehicles].sort((a, b) => {
    if (a.state < b.state) return -1;
    if (a.state > b.state) return 1;
    return 0;
  });

  return (
    <>
      {sortedVehicles.map((vehicle, index) => (
        <div
          key={index}
          onClick={() => onSelectVehicle(vehicle)}
          className={cn(
            "flex cursor-pointer items-center space-x-2 rounded p-2",
            vehicle.plate === selectedVehicle?.plate ? "bg-veloz-primary" : " bg-veloz-neutral-700",
          )}
        >
          <div
            className={cn("h-4 w-1 rounded bg-zinc-500", {
              "bg-emerald-500": vehicle.state === 1,
              "bg-amber-500": vehicle.state === 2,
            })}
          />
          <div className="text-sm font-medium">{vehicle.name}</div>
          <span className="rounded-full bg-veloz-neutral-900 px-3 text-xs spac">{vehicle.plate}</span>
          <span className="rounded-full bg-veloz-neutral-900 px-3 text-xs uppercase">{vehicle.type}</span>
        </div>
      ))}
    </>
  );
};

export default Vehicles;
