import React, { Component } from "react"
import ReactMarkdown from "react-markdown"

class Markdown extends Component {
  state = {
    post: null,
  }

  componentDidMount() {
    fetch(this.props.source)
      .then(res => res.text())
      .then(post => this.setState(state => ({ ...state, post })))
      .catch(err => console.error(err))
  }

  render() {
    const { post } = this.state
    return (
      <div className="markdown">
        <ReactMarkdown source={post} />
      </div>
    )
  }
}

export default Markdown
