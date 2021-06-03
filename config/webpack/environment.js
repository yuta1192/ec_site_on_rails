const { environment } = require(‘@rails/webpacker’)
const path = require(‘path’)

// sass-loaderの設定を取得
const sassLoaders = environment.loaders.get(‘sass’)
const sassLoaderConfig = sassLoaders.use.filter(config => config.loader === ‘sass-loader’)[0]

// sass-loaderに自動ロードの設定をがっちゃんこする
Object.assign(sassLoaderConfig.options, {
data: “@import ‘global-imports.scss’;”,
includePaths: [path.resolve(__dirname, ‘../../app/javascript/stylesheets/’)]
})

module.exports = environment
