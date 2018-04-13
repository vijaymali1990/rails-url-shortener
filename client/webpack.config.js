/* eslint comma-dangle: ["error",
 {"functions": "never", "arrays": "only-multiline", "objects":
 "only-multiline"} ] */

const webpack = require('webpack');
const pathLib = require('path');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const devBuild = process.env.NODE_ENV !== 'production';

const config = {
  entry: [
    './app/bundles/url/startup/registration',
  ],
  output: {
    filename: 'webpack-bundle.js',
    path: pathLib.resolve(__dirname, '../app/assets/webpack'),
    publicPath: '/assets/',
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]',
  },

  resolve: {
    extensions: ['.js', '.jsx', '.png', '.css'],
    modules: ['node_modules', 'client/node_modules'],
  },
  plugins: [
    new webpack.EnvironmentPlugin({ NODE_ENV: 'development' }),
    new ExtractTextPlugin("styles.css"),
  ],
  module: {
    rules: [
      {
        test: require.resolve('react'),
        use: {
          loader: 'imports-loader',
          options: {
            shim: 'es5-shim/es5-shim',
            sham: 'es5-shim/es5-sham',
          }
        },
      },
      {
        test: /\.jsx?$/,
        use: 'babel-loader',
        exclude: /node_modules/,
      },{
      test: /\.scss$/,
      loader: 'style-loader!css!postcss!sass'
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract({
        fallback: "style-loader",
        use: "css-loader"
      })
    }, {
      test: /\.json$/,
      loader: 'json'
    }, {
      test: /\.(eot|woff|woff2|ttf)(\?\S*)?$/,
      loader: 'url?limit=100000@name=[name][ext]'
    },
    {
      test: /\.(jpe?g|png|gif|svg)$/i,
      loaders: [
        'file-loader?hash=sha512&digest=hex&name=[hash].[ext]',
        'image-webpack-loader?bypassOnDebug&optimizationLevel=7&interlaced=false'
      ]
    }
    ],
  },
};

module.exports = config;

if (devBuild) {
  console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
