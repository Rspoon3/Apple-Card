module.exports = {
    entry: "./index.js",
    mode: "development",
    module: {
        rules: [
            {
                test: /\.(eot|md|svg|ttf|woff|woff2)$/,
                use: {
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                    },
                },
            },
        ],
    },
    output: {
        filename: "bundle.js"
    },
};