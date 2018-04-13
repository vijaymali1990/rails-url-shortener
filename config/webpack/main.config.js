var path = require('path');
var webpack = require('webpack');
var BowerWebpackPlugin = require("bower-webpack-plugin");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

var dirname = path.join(__dirname, '../', '../');

var config = module.exports = {
  // the base path which will be used to resolve entry points
  context: dirname,
  devtool: 'source-map',
  // the main entry point for our application's frontend JSON
  entry: {
    redesign: './app/frontend/application'
  },
  output: {
    // this is our app/assets/javascripts directory, which is part of the Sprockets pipeline
    path: path.join(dirname, 'app', 'assets', 'bundles'),
    // the filename of the compiled bundle, e.g. app/assets/javascripts/bundle.js
    filename: 'redesign.js',
    // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
    publicPath: '/connect/assets/',
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  },
  resolve: {
    // tell webpack which extensions to auto search when it resolves modules. With this,
    // you'll be able to do `require('./utils')` instead of `require('./utils.js')`
    extensions: ['', '.js', '.es6', '.css', '.png', '.gif'],
    // by default, webpack will search in `web_modules` and `node_modules`. Because we're using
    // Bower, we want it to look in there too
    modulesDirectories: ['node_modules', 'vendor/assets/components']
  },
  plugins: [
    // we need this plugin to teach webpack how to find module entry points for bower files,
    // as these may not have a package.json file
    new BowerWebpackPlugin({
      modulesDirectories: ["vendor/assets/components"],
      includes:           /\.*$/
    }),
    // This will now automatically inject the $ and jQuery variables into every module,
    // so we no longer need to require them
    new webpack.ProvidePlugin({
      $:               'jquery',
      jQuery:          'jquery',
      'window.jQuery': 'jquery' // for highcharts
    })
  ],
  module: {
    loaders: [
      // **IMPORTANT** This is needed so that each bootstrap js file required by
      // bootstrap-webpack has access to the jQuery object
      { test: /bootstrap\/js\//, loader: 'imports?jQuery=jquery' },
      // font-awesome + bootstrap
      { test: /\.woff(2)?(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=10000&mimetype=application/font-woff" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,      loader: "url?limit=10000&mimetype=application/octet-stream" },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,      loader: "file" },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,      loader: "url?limit=10000&mimetype=image/svg+xml" },
      // Extract css files
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!autoprefixer-loader!resolve-url")
      },
      {
        test: /\.less$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!resolve-url!less-loader")
      },
      {
        test: /\.config\.scss$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!sass-loader!autoprefixer-loader")
      },
      {
        test: function(s) { return !s.match(/\.config\.scss$/) && !!s.match(/\.scss$/); },
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!sass-loader!autoprefixer-loader!resolve-url!sass?sourceMap")
      },
      // Images
      { test: /\.(jpe?g|png|gif|svg)$/i, loader: 'url?limit=10000!img?progressive=true' },
      // es6 files
      {
        test: /\.(es6|jsx)$/,
        exclude: /(node_modules|vendor)/,
        loader: 'babel',
        query: {
          presets: ['es2015', 'stage-2'],
          plugins: [
            ['babel-root-import', { rootPathSuffix: "app/frontend/" }]
          ]
        }
      },
      // ESLint
      {
        test: /\.(es6)$/,
        loader: "eslint-loader",
        exclude: /(node_modules|vendor)/
      },
      {
        include: /\.json$/,
        loaders: ['json-loader']
      }
    ]
  },
  eslint: {
    configFile: '.eslintrc'
  }
};
