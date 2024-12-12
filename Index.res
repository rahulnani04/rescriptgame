open Js.Option
open ReactDOM
switch document->querySelector("#root") {
| Some(rootElement) =>
  let root = Client.createRoot(rootElement)
  root.render(<App />)
| None => ()
}
