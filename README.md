O projeto é composto de 5 módulos:

- sevenSegment
- prioritizer
- controlUnit
- counter

No arquivo testbench.v se encontram os testes de cada módulo, sendo controlUnitTB o mais importante deles e que engloba todos os outros.

Como testar?

Todos os elevadores (A,B e C) estão inicialmente parados no andar 0. Para ajustar a posição inicial conforme desejado, é necessário ajustar a variável objFloor e aguardar o delay necessário para o elevador chegar na posição desejada.
Em seguida ajustar a sequência de eventos que acontecem no sistema, (as variáveis objFloor representam a vontade de um usuário internamente ao elevador, enquanto a variável obj, representa um usuário externamente quer chamar um elevador)
