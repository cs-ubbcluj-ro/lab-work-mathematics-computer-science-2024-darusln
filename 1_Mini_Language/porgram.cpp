#include <iostream>

using namespace std;

int main(){
    int x;
    x = 10;
    int y;
    y = 5;
    float z;
    z = 0;
    
    cout<<"Enter a number:";
    cin>>x;
    
    if (x > y){
        z = x + y;
    }
    else{
        z = x - y;
    }
    cout<<"The result is:";
    cout<<z;
    
    while (z < 100){
        z = z + 1;
        cout<<z;
    }
}
