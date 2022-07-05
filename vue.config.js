// Configuration for the demo application, i.e., yarn serve
module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? '/vue-echemdb/app/' : '/',
  configureWebpack: {
    devServer: {
      watchOptions: {
        ignored: ['node_modules/**'],
      }
    },
    plugins: [],
  },
}
