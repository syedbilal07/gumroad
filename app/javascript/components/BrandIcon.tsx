import * as React from "react";

import { classNames } from "$app/utils/classNames";

type BrandIconProps = {
  name: string;
  className?: string;
} & React.ComponentPropsWithoutRef<"span">;

export const BrandIcon = ({ name, className, style, ...props }: BrandIconProps) => {
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  const maskImage = `url(${require(`images/brands/${name}.svg`)})`;
  return (
    <span
      className={classNames(
        "inline-block shrink-0 bg-current align-middle",
        "min-h-[max(1lh,1em)] w-[1em]",
        className,
      )}
      style={{
        ...style,
        mask: `${maskImage} center / 100% no-repeat`,
        WebkitMask: `${maskImage} center / 100% no-repeat`,
      }}
      {...props}
    />
  );
};
