unit UChatGPT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.HttpClient, System.JSON;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function AskChatGPT(AQuestion: string): string;
var
  _Client: THTTPClient;
  _PostData, sString: string;
  _JsonValue, _Choice, _Message: TJsonValue;
  _Response: IHTTPResponse;
  _DataStream: TStringStream;
  _JSONObject: TJSONObject;
  _JSONArray: TJSONArray;
begin
  Result := '';

  _PostData := '{' +
    '"model": "gpt-3.5-turbo",' +
    '"messages": [{' +
      '"role": "user", "content": "' + AQuestion + '"' +
    '}],' +
    '"temperature": 0.7' +
  '}';

  _DataStream := TStringStream.Create(_PostData);

  try
    _DataStream.Position := 0;
    _Client := THTTPClient.Create;
    try
      _Client.CustomHeaders['Authorization'] := 'Bearer ' + 'API-Key';
      _Client.CustomHeaders['Content-Type'] := 'application/json';

      _Response := _Client.Post('https://api.openai.com/v1/chat/completions', _DataStream);

      if _Response.StatusCode = 200 then
      begin
        sString := _Response.ContentAsString;
        _JsonValue := TJSONObject.ParseJSONValue(sString);

        if Assigned(_JsonValue) and (_JsonValue is TJSONObject) then
        begin
          _JSONArray := (_JsonValue as TJSONObject).GetValue<TJSONArray>('choices');
          if Assigned(_JSONArray) and (_JSONArray.Count > 0) then
          begin
            _JSONObject := _JSONArray.Items[0] as TJSONObject;
            _Message := _JSONObject.GetValue<TJSONObject>('message');
            Result := _Message.GetValue<string>('content');
          end;
        end;
      end
      else
      begin
        raise Exception.Create('Error: ' + IntToStr(_Response.StatusCode));
      end;
    finally
      _Client.Free;
    end;
  finally
    _DataStream.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.Add(AskChatGPT(Edit1.Text));
end;

end.

