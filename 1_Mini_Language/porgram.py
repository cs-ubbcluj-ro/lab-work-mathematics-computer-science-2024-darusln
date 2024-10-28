def main():
    x = 10
    y = 5
    z = 0
    
    print("Enter a number:")
    input(x)
    
    if x > y:
        z = x + y
    else:
        z = x - y
    
    print("The result is:")
    print(z)
    
    while z < 100:
        z = z + 1
        print(z)
