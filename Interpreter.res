// Interpreter.res
open DomainLanguage

type gameState = {
  position: position,
  score: int,
  collectedItems: list<collectible>,
  completedChallenges: list<challenge>,
}

let initialState = {
  position: (0, 0),
  score: 0,
  collectedItems: list{},
  completedChallenges: list{},
}

let movePosition = (pos: position, dir: direction): position => {
  let (x, y) = pos
  switch dir {
  | Forward => (x, y + 1)
  | Backward => (x, y - 1)
  | Left => (x - 1, y)
  | Right => (x + 1, y)
  }
}

let calculatePoints = (item: collectible): int => {
  switch item {
  | CodeGem(_) => 10
  | StarPower(points) => points
  | TreasureBox(items) => List.length(items) * 5
  }
}

let rec executeCommand = (state: gameState, command: heroCommand): gameState => {
  switch command {
  | Walk(dir) => {...state, position: movePosition(state.position, dir)}
  | Jump(power) => {...state, score: state.score + power * 2}
  | Collect(item) => {
      let points = calculatePoints(item)
      {...state, score: state.score + points, collectedItems: list{item, ...state.collectedItems}}
    }
  | SolvePuzzle(challenge) => {
      {...state, score: state.score + challenge.points, completedChallenges: list{challenge, ...state.completedChallenges}}
    }
  | RepeatTimes(n, cmd) => {
      let rec loop = (currentState, i) =>
        if i <= 0 {
          currentState
        } else {
          loop(executeCommand(currentState, cmd), i - 1)
        }
      loop(state, n)
    }
  | Sequence(commands) => Belt.List.reduce(commands, state, executeCommand)
  | IfThen(condition, cmd) => if condition {executeCommand(state, cmd)} else {state}
  | Rotate(dir) => {
      
      {...state, position: movePosition(state.position, dir)}
    }
  | Pick(itemName) => {
      let item = CodeGem(Variable(itemName)) 
      {...state, collectedItems: list{item, ...state.collectedItems}, score: state.score + 5}
    }
  | Drop(itemName) => {
      let filteredItems = Belt.List.keep(state.collectedItems, item =>
        switch item {
        | CodeGem(Variable(name)) => name != itemName
        | _ => true
        }
      )
      {...state, collectedItems: filteredItems}
    }
  }
}

let runProgram = (program: program): gameState => List.fold_left(executeCommand, initialState, program)
