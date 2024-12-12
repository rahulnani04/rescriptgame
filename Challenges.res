type challenge = {
  id: int,
  title: string,
  description: string,
  hints: array<string>,
  expectedCommands: list<DomainLanguage.heroCommand>,
  points: int,
}

let allChallenges = [
  {
    id: 1,
    title: "First Steps in Programming",
    description: "Move the hero forward and collect the variable 'score'",
    hints: ["Try using Walk(Forward)", "Don't forget to Collect the variable!"],
    expectedCommands: list{
      Walk(Forward),
      Collect(CodeGem(Variable("score")))
    },
    points: 50
  },
  {
    id: 2,
    title: "Learning Loops",
    description: "Jump three times to understand repeating actions",
    hints: ["Use RepeatTimes(3, Jump(1))", "This is like a 'for' loop in programming"],
    expectedCommands: list{
      RepeatTimes(3, Jump(1))
    },
    points: 75
  }
]