program Sisteminha;

{$APPTYPE CONSOLE}

{$R *.res}

uses System.SysUtils,
     Windows;

procedure LimparTela;
var
  hConsole: THandle;
  ConsoleInfo: CONSOLE_SCREEN_BUFFER_INFO;
  ConsoleSize: DWORD;
  CoordZero: TCoord;
  CharsWritten: DWORD;
begin
  hConsole := GetStdHandle(STD_OUTPUT_HANDLE);
  GetConsoleScreenBufferInfo(hConsole, ConsoleInfo);

  ConsoleSize := ConsoleInfo.dwSize.X * ConsoleInfo.dwSize.Y;
  CoordZero.X := 0;
  CoordZero.Y := 0;

  FillConsoleOutputCharacter(hConsole, ' ', ConsoleSize, CoordZero, CharsWritten);
  FillConsoleOutputAttribute(hConsole, ConsoleInfo.wAttributes, ConsoleSize, CoordZero, CharsWritten);
  SetConsoleCursorPosition(hConsole, CoordZero);
end;

var logado: Boolean;

procedure MostrarMenu;
begin
  WriteLn('-------- Menu --------');
  WriteLn('| 1 - Realizar Login |');
  WriteLn('|                    |');
  WriteLn('| 9 - Sair           |');
  WriteLn('----------------------');
  Write('Digite seu destino: ');
end;

procedure MostrarMenuCadastro;
begin
  WriteLn('---------- Menu ---------');
  WriteLn('| 1 - Adicionar usuário |');
  WriteLn('|                       |');
  WriteLn('| 9 - Logout            |');
  WriteLn('-------------------------');
  Write('Digite seu destino: ');
end;

const usuarioAdmin:String = 'admin';
      senhaAdmin:String = 'admin';

function LoginValido(usuario, senha: String):Boolean;
begin
  result := false;
  if (usuario = usuarioAdmin) and (senha = senhaAdmin) then begin
    logado := true;
    result := true;
  end;
end;

var usuario, senha, opcaoDoUsuario, nome, email: String;
    tentativasDeLogin, idade: Integer;
begin
  try
    while True do begin
      MostrarMenu;
      ReadLn(opcaoDoUsuario);
      LimparTela;
      if (opcaoDoUsuario='1') then begin
        tentativasDeLogin := 0;
        while True do begin
          if tentativasDeLogin = 3 then begin
            WriteLn('Limite de tentativas de login excedido.');
            WriteLn('Finalizando a aplicação...');
            Sleep(1500);
            Exit;
          end;
          Write('Digite seu Usuário: ');
          ReadLn(usuario);
          Write('Digite sua senha: ');
          ReadLn(senha);
          if LoginValido(usuario, senha) then begin
            WriteLn('Autenticado com sucesso.');
            Sleep(1000);
            break;
          end else begin
            WriteLn('Credenciais incorretas.');
            Sleep(1000);
          end;
          Inc(tentativasDeLogin);
          LimparTela;
        end;
      end else if opcaoDoUsuario = '9' then begin
        WriteLn('Finalizando a aplicação...');
        Sleep(1500);
        Break;
      end else begin
        WriteLn('Opção inválida.');
        Sleep(1000);
      end;
      LimparTela;

      while logado do begin
        MostrarMenuCadastro;
        ReadLn(opcaoDoUsuario);
        if opcaoDoUsuario = '1' then begin
          Write('Digite o nome completo do usuário: ');
          ReadLn(nome);
          Write('Digite a idade do usuário: ');
          ReadLn(idade);
          Write('Digite o e-mail do usuário: ');
          ReadLn(email);
        end else if opcaoDoUsuario = '9' then begin
          logado := false;
        end else begin
          WriteLn('Opção inválida.');
          Sleep(1000);
        end;
        LimparTela;
      end;
    end;
  except
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.Message);
      ReadLn;
    end;
  end;
end.
