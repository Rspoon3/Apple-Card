import React, { Component } from "react"
import Layout from "../components/layout"
import SEO from "../components/seo"
import configs from "../../site-config"
import Footer from "../components/footer"
import Header from "../components/header"
import changelog from "../markdown/change-log.md"
import Markdown from "../components/markdown-importer"

const IndexPage = ({ data }) => (
  <Layout>
    <SEO title={configs.app_name} keywords={configs.app_keywords} />

    <div
      className="imageWrapper"
      style={{
        backgroundImage: `linear-gradient(${configs.cover_overlay_color_rgba},${
          configs.cover_overlay_color_rgba
          }),url(${data.headerImage.childImageSharp.fluid.src})`,
        height: "114px",
        borderRadius: "0"
      }}
    >
      <div className="headerBackground" >
        <div className="container presskitPage">
          <Header data={data} />
          <Markdown source={changelog} />
          <Footer />
        </div>
      </div>
    </div>
  </Layout>
)

export default IndexPage

export const query = graphql`
  query {
    headerIcon: file(relativePath: { eq: "icon.png" }) {
      childImageSharp {
        fluid(maxWidth: 50) {
          ...GatsbyImageSharpFluid
        }
      }
    } 
    headerImage: file(relativePath: { eq: "headerimage.png" }) {
      childImageSharp {
        fluid(maxHeight: 714) {
          ...GatsbyImageSharpFluid
        }
      }
    }
  }
`
