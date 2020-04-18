/**
 * Implement Gatsby's Node APIs in this file.
 *
 * See: https://www.gatsbyjs.org/docs/node-apis/
 */

// You can delete this file if you're not using it

exports.onCreateWebpackConfig = ({
    stage,
    rules,
    loaders,
    plugins,
    actions,
  }) => {
    actions.setWebpackConfig({
        module: {
            rules: [{
                test: /\.md$/,
                use: {
                    loader: 'file-loader',
                    options: {
                      name: '[name].[ext]',
                    },
                  },
            }]
        },
      plugins: [
        plugins.define({
          __DEVELOPMENT__: stage === `develop` || stage === `develop-html`,
        }),
      ],
    })
  }

