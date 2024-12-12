'use strict';

function intToString(x) {
  return x.toString();
}

function boolToString(x) {
  if (x) {
    return "true";
  } else {
    return "false";
  }
}

function levelToString(level) {
  switch (level) {
    case /* Beginner */ 0:
      return "Beginner";
    case /* Intermediate */ 1:
      return "Intermediate";
    case /* Advanced */ 2:
      return "Advanced";
  }
}

function describeCommand(command) {
  switch (command.TAG | 0) {
    case /* Walk */ 0:
      var dirStr;
      switch (command._0) {
        case /* Forward */ 0:
          dirStr = "आगे";
          break;
        case /* Backward */ 1:
          dirStr = "पीछे";
          break;
        case /* Left */ 2:
          dirStr = "बाएं";
          break;
        case /* Right */ 3:
          dirStr = "दाएं";
          break;
      }
      return "Hero moves " + dirStr + " on the coding path!";
    case /* Jump */ 1:
      return "Hero jumps with power level " + command._0.toString() + "!";
    case /* Collect */ 2:
      var item = command._0;
      switch (item.TAG | 0) {
        case /* CodeGem */ 0:
          var concept = item._0;
          switch (concept.TAG | 0) {
            case /* Variable */ 0:
              return "Found a magical variable named " + concept._0 + "!";
            case /* Loop */ 1:
              return (
                "Discovered a loop that repeats " +
                concept._0.toString() +
                " times!"
              );
            case /* Condition */ 2:
              return (
                "Learned about IF conditions: " +
                concept._0 +
                " is " +
                (concept._1 ? "true" : "false") +
                "!"
              );
            case /* Function */ 3:
              return "Mastered a new function called " + concept._0 + "!";
          }
        case /* StarPower */ 1:
          return "Gained " + item._0.toString() + " star points!";
        case /* TreasureBox */ 2:
          return "Found a mysterious treasure box full of coding surprises!";
      }
    case /* SolvePuzzle */ 3:
      var challenge = command._0;
      return (
        "Solving a " +
        levelToString(challenge.level) +
        " puzzle about " +
        challenge.topic +
        "!"
      );
    case /* RepeatTimes */ 4:
      return "Let's repeat this action " + command._0.toString() + " times!";
    case /* Sequence */ 5:
      return "Time to do multiple actions in sequence!";
    case /* IfThen */ 6:
      return (
        "If " +
        (command._0 ? "true" : "false") +
        ", then we'll do something special!"
      );
    case /* Rotate */ 7:
      var rotateDir;
      switch (command._0) {
        case /* Forward */ 0:
          rotateDir = "आगे";
          break;
        case /* Backward */ 1:
          rotateDir = "पीछे";
          break;
        case /* Left */ 2:
          rotateDir = "बाएं";
          break;
        case /* Right */ 3:
          rotateDir = "दाएं";
          break;
      }
      return "Hero rotates to " + rotateDir + "!";
    case /* Pick */ 8:
      return "Hero picks up " + command._0 + "!";
    case /* Drop */ 9:
      return "Hero drops " + command._0 + "!";
  }
}

exports.intToString = intToString;
exports.boolToString = boolToString;
exports.levelToString = levelToString;
exports.describeCommand = describeCommand;