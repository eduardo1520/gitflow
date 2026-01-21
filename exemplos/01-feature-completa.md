# Exemplo: Workflow Completo de uma Feature

Este exemplo demonstra o fluxo completo de desenvolvimento de uma feature usando GitFlow.

## Cenário

Você precisa adicionar um sistema de autenticação ao projeto.

## Passo a Passo

### 1. Preparação

```bash
# Garantir que você está na branch develop atualizada
git checkout develop
git pull origin develop
```

### 2. Criar Feature Branch

```bash
git flow feature start user-authentication
```

### 3. Desenvolver a Feature

```bash
# Criar arquivo de autenticação
cat > auth.js << 'EOF'
// Sistema de Autenticação
class AuthService {
    constructor() {
        this.users = [];
    }
    
    register(username, password) {
        const user = { username, password };
        this.users.push(user);
        return user;
    }
    
    login(username, password) {
        const user = this.users.find(u => 
            u.username === username && u.password === password
        );
        return user ? { success: true, user } : { success: false };
    }
}

module.exports = AuthService;
EOF

# Adicionar ao git
git add auth.js
git commit -m "feat: adiciona sistema básico de autenticação"
```

### 4. Continuar Desenvolvimento

```bash
# Adicionar testes
cat > auth.test.js << 'EOF'
const AuthService = require('./auth');

describe('AuthService', () => {
    test('deve registrar novo usuário', () => {
        const auth = new AuthService();
        const user = auth.register('john', 'pass123');
        expect(user.username).toBe('john');
    });
});
EOF

git add auth.test.js
git commit -m "test: adiciona testes para sistema de autenticação"
```

### 5. Finalizar Feature

```bash
git flow feature finish user-authentication
```

### 6. Enviar Mudanças

```bash
git push origin develop
```

## Comandos Resumidos

```bash
# 1. Atualizar develop
git checkout develop && git pull origin develop

# 2. Criar feature
git flow feature start user-authentication

# 3. Desenvolver
git add . && git commit -m "feat: descrição"

# 4. Finalizar
git flow feature finish user-authentication

# 5. Enviar
git push origin develop
```
