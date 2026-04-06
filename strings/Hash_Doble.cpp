#include "../setup/template.h"
// snippet: hash
struct Hash {//doble hashing
    vector<ll> h1, h2;
    vector<ll> p1, p2;
    ll p=31;//tomamos esta p para evitar colisiones
    Hash(string &s) {
        int n = s.size();
        h1.resize(n+1, 0);
        h2.resize(n+1, 0);
        p1.resize(n+1, 1);
        p2.resize(n+1, 1);
//hacemos doble hasheo para evitar colisiones
        for (int i = 0; i < n; i++) {
            p1[i+1] = (p1[i] * p) % MOD;//a uno le aplicamos modulo
            p2[i+1] = (p2[i] * p);//el otro ocupamos el modulo implicito de ll
//uno con mod 10e9+7 y otro con 2e64 que es LLONG_MAX
            int val = s[i] - 'a' + 1;//hasheamos con el asci
 
            h1[i+1] = (h1[i] * p + val) % MOD;
            h2[i+1] = (h2[i] * p + val);
        }
    }
 
    pair<ll,ll> get(ll l, ll r) {//comparamos los 2 hashing
        ll x1 = (h1[r+1] - h1[l] * p1[r-l+1] % MOD + MOD) % MOD;
        ll x2 = (h2[r+1] - h2[l] * p2[r-l+1]);
        return {x1, x2};
    }
};
Hash hs(s);//inicializar
hs.get(i,j);//lugar de sonde se compara 
if(hs.get(l,m)==hs.get(i,j))//si 2 cadenas son iguales
// snippet: end
