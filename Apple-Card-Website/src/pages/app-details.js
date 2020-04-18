import React from "react"
import { graphql } from "gatsby"

import Layout from "../components/layout"
import Header from "../components/header"
import SEO from "../components/seo"

import "@fortawesome/fontawesome-free/css/all.min.css"

import configs from "../../site-config"
import Footer from "../components/footer"


import aboutMe from "../markdown/about-me.md"
import appDescription from "../markdown/description.md"
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
      <div className="headerBackground">
        <div className="container presskitPage">
          <Header data = {data}/>
          <div className="presskit-body">
            <h2>  </h2> 
            {/* <p>Download full Press Kit with screenshots, promo art, and hi-res icon <a href={configs.presskit_download_link}>here</a>.</p> */}
            <div className="presskit-hero">
              <a href="/screenshots/app-store/device_banner.png">
                <img src="/screenshots/app-store/device_banner.png" />
              </a>
            </div>
            <Markdown source={appDescription} />
            <h2>Promo Images</h2>
            <div className="presskit-banner">
              <a href="/screenshots/app-store/promo_banner.png">
                <img src="/screenshots/app-store/promo_banner.png" />
              </a>
            </div>
            <div className="presskit-banner">
              <a href="/screenshots/app-store/device_promo_banner.png">
                <img src="/screenshots/app-store/device_promo_banner.png" />
              </a>
            </div>
            <div className="presskit-iphone-screenshots">
              <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_01.png">
                    <img src="/screenshots/app-store/screenshot_iphone_01.png" />
                  </a>
              </div>
              <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_02.png">
                    <img src="/screenshots/app-store/screenshot_iphone_02.png" />
                  </a>
              </div>
              <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_03.png">
                    <img src="/screenshots/app-store/screenshot_iphone_03.png" />
                  </a>
              </div>
            </div>
            <div className="presskit-iphone-screenshots">
            <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_04.png">
                    <img src="/screenshots/app-store/screenshot_iphone_04.png" />
                  </a>
              </div>
              <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_05.png">
                    <img src="/screenshots/app-store/screenshot_iphone_05.png" />
                  </a>
              </div>
              <div className="presskit-screenshot">
                  <a href="/screenshots/app-store/screenshot_iphone_06.png">
                    <img src="/screenshots/app-store/screenshot_iphone_06.png" />
                  </a>
              </div>
            </div>            
          </div>
          <Markdown source={aboutMe} />
          <Footer/>
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
    appStore: file(relativePath: { eq: "appstore.png" }) {
      childImageSharp {
        fixed(width: 220) {
          ...GatsbyImageSharpFixed
        }
      }
    }
    playStore: file(relativePath: { eq: "playstore.png" }) {
      childImageSharp {
        fixed(height: 75) {
          ...GatsbyImageSharpFixed
        }
      }
    }
    iphoneScreen: file(relativePath: { glob: "screenshot/*.{png,jpg}" }) {
      childImageSharp {
        fluid(maxWidth: 350) {
          ...GatsbyImageSharpFluid
        }
      }
    }
    videoScreen: file(
      extension: { ne: "txt" }
      relativePath: { glob: "videos/*" }
    ) {
      publicURL
      extension
    }
    appIconLarge: file(relativePath: { eq: "icon.png" }) {
      childImageSharp {
        fluid(maxWidth: 120) {
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
    iphonePreviewBlack: file(relativePath: { eq: "black.png" }) {
      childImageSharp {
        fluid(maxWidth: 400) {
          ...GatsbyImageSharpFluid
        }
      }
    }
    iphonePreviewBlue: file(relativePath: { eq: "blue.png" }) {
      childImageSharp {
        fluid(maxWidth: 400) {
          ...GatsbyImageSharpFluid
        }
      }
    }
    iphonePreviewCoral: file(relativePath: { eq: "coral.png" }) {
      childImageSharp {
        fluid(maxWidth: 400) {
          ...GatsbyImageSharpFluid
        }
      }
    }
    iphonePreviewWhite: file(relativePath: { eq: "white.png" }) {
      childImageSharp {
        fluid(maxWidth: 400) {
          ...GatsbyImageSharpFluid
        }
      }
    }
    iphonePreviewYellow: file(relativePath: { eq: "yellow.png" }) {
      childImageSharp {
        fluid(maxWidth: 400) {
          ...GatsbyImageSharpFluid
        }
      }
    }
  }
`
