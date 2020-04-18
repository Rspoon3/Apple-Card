import React, { Component } from "react"
import Link from "gatsby-link"
import configs from "../../site-config"

class Footer extends Component {
  render() {
    return (
      <footer>
        <p className="footerText">
          Made by{" "}
          {configs.your_link ? (
            <a href={configs.your_link}>{configs.your_name}</a>
          ) : (
            `${configs.your_name}`
          )}
          {configs.your_city && ` in ${configs.your_city}`}
        </p>
        <div className="footerIcons">
          {configs.facebook_username && (
            <a
              href={`https://facebook.com/${configs.facebook_username}`}
              aria-label="Facebook"
            >
              <span className="fa-stack fa-1x">
                <i className="socialIconBack fas fa-circle fa-stack-2x" />
                <i className="socialIconTop fab fa-facebook fa-stack-1x" />
              </span>
            </a>
          )}

          {configs.linkedin_username && (
            <a
              href={`https://www.linkedin.com/in/${configs.linkedin_username}`}
              aria-label="LinkedIn"
            >
              <span className="fa-stack fa-1x">
                <i className="socialIconBack fas fa-circle fa-stack-2x" />
                <i className="socialIconTop fab fa-linkedin fa-stack-1x" />
              </span>
            </a>
          )}

          {configs.twitter_username && (
            <a
              href={`https://twitter.com/${configs.twitter_username}`}
              aria-label="Twitter"
            >
              <span className="fa-stack fa-1x">
                <i className="socialIconBack fas fa-circle fa-stack-2x" />
                <i className="socialIconTop fab fa-twitter fa-stack-1x" />
              </span>
            </a>
          )}

          {configs.github_username && (
            <a
              href={`https://github.com/${configs.github_username}`}
              aria-label="GitHub"
            >
              <span className="fa-stack fa-1x">
                <i className="socialIconBack fas fa-circle fa-stack-2x" />
                <i className="socialIconTop fab fa-github fa-stack-1x" />
              </span>
            </a>
          )}

          {configs.email_address && (
            <a href={`mailto:${configs.email_address}`} aria-label="Email">
              <span className="fa-stack fa-1x">
                <i className="socialIconBack fas fa-circle fa-stack-2x" />
                <i className="socialIconTop fas fa-envelope fa-stack-1x" />
              </span>
            </a>
          )}
        </div>
        <div className="footer-privacy">
          {/* <Link to="/privacy-policy">Privacy Policy</Link> */}
        </div>
      </footer>
    )
  }
}

export default Footer
