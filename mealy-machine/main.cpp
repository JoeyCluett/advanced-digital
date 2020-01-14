#include <iostream>
#include <string>

using namespace std;

int main(int argc, char* argv[]) {

    string input    = "001101100101010";
    string expected = "000001000001010";

    {
        cout << "\n\tFour state machine\n";
        cout << "\t" << input << " <- input " << endl << "\t";
        
        int current_state = 0;
        for(char c : input) {
            switch(current_state) {
                case 0:
                    if(c == '0') 
                        cout << '0';
                    else {
                        current_state = 1;
                        cout << '0';
                    }
                    break;
                case 1:
                    if(c == '1')
                        cout << '0';
                    else {
                        current_state = 2;
                        cout << '0';
                    }
                    break;
                case 2:
                    if(c == '0') {
                        current_state = 0;
                        cout << '0';
                    }
                    else {
                        current_state = 3;
                        cout << '1';
                    }
                    break;
                case 3:
                    if(c == '0') {
                        current_state = 2;
                        cout << '0';
                    }
                    else {
                        current_state = 1;
                        cout << '0';
                    }
                    break;
                default:
                    cout << "\n\nERROR\n";
                    exit(1);
            }
        }

        cout << " <- output" << endl << "\t" << expected << " <- expected output" << endl;
    }

    {
        cout << "\n\tThree state machine\n";
        cout << "\t" << input << " <- input " << endl << "\t";

        int current_state = 0;
        for(char c : input) {
            switch(current_state) {
                case 0:
                    if(c == '0')
                        cout << '0';
                    else {
                        current_state = 1;
                        cout << '0';
                    }
                    break;
                case 1:
                    if(c == '0') {
                        current_state = 2;
                        cout << '0';
                    }
                    else {
                        cout << '0';
                    }
                    break;
                case 2:
                    if(c == '0') {
                        current_state = 0;
                        cout << '0';
                    }
                    else {
                        current_state = 1;
                        cout << '1';
                    }
                    break;
                default:
                    cout << "\n\nERROR\n";
                    exit(1);
            }
        }

        cout << " <- output" << endl << "\t" << expected << " <- expected output" << endl << endl;
    }

    return 0;
}
