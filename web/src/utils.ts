import { ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export type TVehicle = {
  type: string;
  garageId: string;
  plate: string;
  model: undefined;
  state: number;
  properties: undefined;
  name: string;
  stats: {
    engine: number;
    body: number;
    fuel: number;
    distance: number;
  };
};

export type TGarage = {
  type: string;
  id: string;
  label: string;
  impound?: boolean;
};

export async function fetchData(eventName: string, data?: unknown) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const resourceName = (window as any).GetParentResourceName
    ? // eslint-disable-next-line @typescript-eslint/no-explicit-any
      (window as any).GetParentResourceName()
    : "nui-frame-app";

  const response = await fetch(`https://${resourceName}/${eventName}`, {
    method: "post",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(data),
  });

  return await response.json();
}

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
