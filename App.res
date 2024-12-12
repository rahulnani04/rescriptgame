@react.component
let default = () => {
  let (questInput, setQuestInput) = React.useState(_ => "")
  let (output, setOutput) = React.useState(_ => "")

  let handleSubmit = event => {
    ReactEvent.Form.preventDefault(event)
    
    // Example program
    let program = list{
      Walk(Forward),
      Collect(CodeGem(Variable("myVariable"))),
      RepeatTimes(3, Jump(5)),
    }

    let result = Interpreter.runProgram(program)
    setOutput(_ => result)
  }

  <div className="game-container">
    <div className="code-input">
      <textarea
        value={questInput}
        onChange={e => setQuestInput(ReactEvent.Form.target(e)["value"])}
        placeholder="Write your adventure code here..."
        className="code-textarea"
      />
      <button 
        onClick={handleSubmit}
        className="run-button"
      >
        {"Run Adventure"->React.string}
      </button>
    </div>
    
    <div className="output-display">
      {output->React.string}
    </div>
  </div>
}



