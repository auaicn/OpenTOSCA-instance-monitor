// 가장 기본적인 컴포넌트 정의법
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

// 클래스를 이용한 컴포넌트 정의법
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
