class FiniteAutomaton:
    def __init__(self, file_name):
        self.states = set()
        self.alphabet = set()
        self.transitions = {}
        self.start_state = None
        self.final_states = set()
        self.load_from_file(file_name)

    def load_from_file(self, file_name):
        with open(file_name, 'r') as file:
            lines = [line.strip() for line in file.readlines()]

        self.states = set(lines[0].split(","))
        self.alphabet = set(lines[1].split(","))
        self.start_state = lines[2]
        self.final_states = set(lines[3].split(","))

        for line in lines[4:]:
            parts = line.split(",")
            state, symbol, next_state = parts[0], parts[1], parts[2]
            if (state, symbol) not in self.transitions:
                self.transitions[(state, symbol)] = []
            self.transitions[(state, symbol)].append(next_state)

    def display(self):
        print("Set of States:", self.states)
        print("Alphabet:", self.alphabet)
        print("Transitions:")
        for (state, symbol), next_states in self.transitions.items():
            print(f"  δ({state}, {symbol}) -> {next_states}")
        print("Start State:", self.start_state)
        print("Set of Final States:", self.final_states)

    def is_valid_token(self, token):
        current_state = self.start_state
        for symbol in token:
            if (current_state, symbol) not in self.transitions:
                return False
            current_state = self.transitions[(current_state, symbol)][0]
        return current_state in self.final_states


# Main execution
if __name__ == "__main__":
    fa = FiniteAutomaton("FA.in")
    fa.display()

    # BONUS: Verify if a string is a valid lexical token
    test_string = input("Enter a string to check if it's a valid lexical token: ")
    if fa.is_valid_token(test_string):
        print(f"The string '{test_string}' is a valid lexical token.")
    else:
        print(f"The string '{test_string}' is NOT a valid lexical token.")
