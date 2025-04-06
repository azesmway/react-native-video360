import * as React from "react";
import { ViewProps } from "react-native";

interface Video360Props {
  source:
    | {
        uri: string;
      }
    | number;
}

export default class Video360 extends React.Component<
  Video360Props & ViewProps,
  any
> {}
