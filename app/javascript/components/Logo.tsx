import * as React from "react";

import { classNames } from "$app/utils/classNames";

type LogoProps = {
  variant?: "full" | "g";
  className?: string;
} & React.ComponentPropsWithoutRef<"span">;

export const Logo = ({ variant = "full", className, style, ...props }: LogoProps) => {
  if (variant === "g") {
    return (
      <span
        className={classNames(
          "block bg-contain bg-no-repeat",
          "h-[--big-icon-size] w-[--big-icon-size]",
          className,
        )}
        // eslint-disable-next-line @typescript-eslint/no-require-imports
        style={{ ...style, backgroundImage: `url(${require("images/logo-g.svg")})` }}
        {...props}
      />
    );
  }
  // Full Logo (Ratio: 1 / 0.14)
  return (
    <span
      className={classNames("shrink-0 bg-current", className)}
      style={{
        ...style,
        width: "7.1428em", // Simplified from calc(1em / 0.14)
        minHeight: "max(1lh, 1em)",
        // eslint-disable-next-line @typescript-eslint/no-require-imports
        mask: `url(${require("images/logo.svg")}) center / contain no-repeat`,
        // eslint-disable-next-line @typescript-eslint/no-require-imports
        WebkitMask: `url(${require("images/logo.svg")}) center / contain no-repeat`,
      }}
      {...props}
    />
  );
};
