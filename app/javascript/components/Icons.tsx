import * as React from "react";

import { classNames } from "$app/utils/classNames";

// If you have a type for IconName, import it. Otherwise, use string.
// import { IconName } from "types/icons";
type IconProps = {
  name: string;
  className?: string;
} & React.ComponentPropsWithoutRef<"span">;

export const Icon = ({ name, className, style, ...props }: IconProps) => {
  // Use require dynamically for webpack to resolve the asset
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  const maskImage = `url(${require(`images/icons/${name}.svg`)})`;
  return (
    <span
      className={classNames(
        "inline-block shrink-0 bg-current align-middle",
        "min-h-[max(1lh,1em)] w-[1em]",
        className,
      )}
      style={{
        ...style,
        mask: `${maskImage} center / 120% no-repeat`,
        WebkitMask: `${maskImage} center / 120% no-repeat`, // Ensure fallback if needed
      }}
      aria-hidden="true"
      {...props}
    />
  );
};
