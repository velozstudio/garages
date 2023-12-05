import { type TGarage, cn, TVehicle } from "../utils";

interface GaragesProps {
  garages: TGarage[];
  vehicles: TVehicle[];
  currentGarageId: string;
  currentSelectedGarageId: string;
  onSelectedGarage: (garage: TGarage) => void;
}

const Garages = ({ garages, vehicles, currentGarageId, currentSelectedGarageId, onSelectedGarage }: GaragesProps) => {
  const reorderedGarages = currentGarageId
    ? [garages.find((garage) => garage.id === currentGarageId), ...garages.filter((garage) => garage.id !== currentGarageId)]
    : garages;

  return (
    <div className="w-full max-w-[15rem] space-y-1 border-r border-white/5 pr-1">
      {reorderedGarages.map((garage, index) => (
        <div
          key={index}
          className={cn(
            "flex cursor-pointer items-center justify-between truncate rounded p-2 text-sm",
            garage?.id === currentSelectedGarageId ? "bg-veloz-primary" : "bg-veloz-neutral-700",
          )}
          onClick={() => onSelectedGarage(garage!)}
        >
          <span className={cn(garage!.label.length > 30 ? "text-xs" : null)}>{garage?.label}</span>
          <span className="rounded-full bg-veloz-neutral-900 px-3 text-xs">
            {vehicles.filter((vehicle) => vehicle.garageId === garage!.id).length}
          </span>
        </div>
      ))}
    </div>
  );
};

export default Garages;
