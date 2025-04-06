import React, { Component } from "react";
import { requireNativeComponent, ViewPropTypes } from "react-native";
import resolveAssetSource from "react-native/Libraries/Image/resolveAssetSource";
import PropTypes from "prop-types";


const resolveUri = asset => {
  const source = resolveAssetSource(asset) || {};
  let uri = source.uri || '';
  if (uri && uri.match(/^\//)) {
    uri = `file://${uri}`;
  }

  return uri;
}

class Video360Component extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { source, ...viewProps } = this.props;

    if (source && source.uri) {
      return <Video360 urlVideo={source.uri} {...viewProps} />;
    }

    const uri = resolveUri(source)

    if (!uri) {
      return null;
    }

    return <Video360 urlVideo={uri} {...viewProps} />;
  }
}

Video360Component.propTypes = {
  source: PropTypes.oneOfType([
    PropTypes.shape({
      uri: PropTypes.string
    }),
    // Opaque type returned by require('./video360.mp4')
    PropTypes.number
  ]),
  ...ViewPropTypes
};

const Video360 = requireNativeComponent("Video360", Video360Component, {
  nativeOnly: {
    urlVideo: true
  }
});

export default Video360Component;
