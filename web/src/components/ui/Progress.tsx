import { cn } from "../../utils";

interface ProgressProps {
  value: number;
}

const Progress = ({ value }: ProgressProps) => {
  const progressWidth = !isNaN(value) ? `${value}%` : "0%";

  return (
    <div className={cn("h-2 w-full overflow-hidden rounded-sm bg-veloz-neutral-500", isNaN(value) ? "animate-pulse" : null)}>
      <div className="h-full rounded-sm bg-veloz-primary transition-all duration-500 ease-in-out" style={{ width: progressWidth }} />
    </div>
  );
};

export default Progress;
