# Python3 program to check whether there
# exist at least k or not in range [2..n]
primes = [];
 
# Generating all the prime numbers
# from 2 to n.
def SieveofEratosthenes(n):
 
    visited = [False] * (n + 2);
    for i in range(2, n + 2):
        if (visited[i] == False):
            for j in range(i * i, n + 2, i):
                visited[j] = True;
            primes.append(i);
 
def specialPrimeNumbers(n, k):
 
    SieveofEratosthenes(n);
    count = 0;
    for i in range(len(primes)):
        for j in range(i - 1):
 
            # If a prime number is Special
            # prime number, then we increments
            # the value of k.
            if (primes[j] +
                primes[j + 1] + 1 == primes[i]):
                count += 1;
                break;
 
        # If at least k Special prime numbers
        # are present, then we return 1.
        # else we return 0 from outside of
        # the outer loop.
        if (count == k):
            return True;
 
    return False;
 
# Driver Code
n = 100000000;
k = 2;
if (specialPrimeNumbers(n, k)):
    print("YES");
else:
    print("NO");
 
# This code is contributed by mits