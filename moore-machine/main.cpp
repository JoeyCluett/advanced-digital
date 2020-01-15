#include <iostream>
#include <string>

using namespace std;

/*
    Output 1 if
        1.) total no. of 1's received is ODD
        2.) at least two consecutive 0's have been received
*/

int main(int argc, char* argv[]) {

    string input  = "1110101011100110101001001110101010011010";
    string expect = "0000000000000010011000111010011001110110"; // expected output

    {

        cout << "\n\n\t" << input << " <- input\n\t";

        int current_state = 0;
        for(char c : input) {

            switch(current_state) {
                case 0:
                    cout << '0';
                    current_state = (c == '0') ? 1 : 3;
                    break;
                case 1:
                    cout << '0';
                    current_state = (c == '0') ? 2 : 3;
                    break;
                case 2:
                    cout << '0';
                    current_state = (c == '0') ? 2 : 4;
                    break;
                case 3:
                    cout << '0';
                    current_state = (c == '0') ? 5 : 0;
                    break;
                case 4:
                    cout << '1';
                    current_state = (c == '0') ? 4 : 2;
                    break;
                case 5:
                    cout << '0';
                    current_state = (c == '0') ? 4 : 0;
                    break;
                default:
                    cout << "\n\nERROR\n";
                    exit(1);
            }

        }

        cout << " <- output\n\t";
        cout << expect << " <- expected output\n\n";

    }

    return 0;
}


