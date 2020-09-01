unit uAvisos;

interface

uses
   System.SysUtils,
   System.Types,
   System.UITypes,
   System.Classes,
   System.Variants,
   FMX.Types,
   FMX.Controls,
   FMX.Forms,
   FMX.Graphics,
   FMX.Dialogs,
   FMX.Controls.Presentation,
   FMX.StdCtrls,
   FMX.Ani,
   FMX.Objects,
   FMX.Layouts;

Type TFormHelper = class helper for TForm

    procedure AvisoPositivo(msg :String; Cor :TAlphaColor = TAlphaColors.Cornflowerblue);
    procedure AnimaArcFinish(Sender :TObject);
    procedure Anima1Finish(Sender :TObject);
    procedure Anima2Finish(Sender :TObject);
    procedure AnimaSaidaFinish(Sender :TObject);
    procedure AvisoNegativo(msg :String; Cor :TAlphaColor = TAlphaColors.Cornflowerblue);
end;

var
  RetFundo,RetAviso,Rectangle1 ,RetCheck  :TRectangle;
  Arc : TArc;

  Cor : Integer;
  Layout1 :TLayout;
  txt :TText;
  AnimaArc,
  Anima1,
  Anima2,
  AnimaSaida : TFloatAnimation;


implementation

{ TFormHelper }

procedure TFormHelper.Anima1Finish(Sender: TObject);
begin
   Anima2.Start;
end;

procedure TFormHelper.Anima2Finish(Sender: TObject);
begin
   AnimaSaida.Start;
end;

procedure TFormHelper.AnimaArcFinish(Sender: TObject);
begin
   Anima1.Start;
end;

procedure TFormHelper.AnimaSaidaFinish(Sender: TObject);
begin
   RetAviso.DisposeOf;
   RetFundo.DisposeOf;
end;


procedure TFormHelper.AvisoPositivo(msg :String; Cor :TAlphaColor = TAlphaColors.Cornflowerblue);
begin

   {$REGION 'Fundo'}
   RetFundo := TRectangle.Create(Self);
   RetFundo.Fill.Color := TAlphacolors.Black;
   RetFundo.Align := TAlignLayout.Contents;
   RetFundo.Size.PlatformDefault := False;
   RetFundo.Stroke.Color :=  RetFundo.Fill.Color;
   RetFundo.Opacity := 0.1;
   RetFundo.Parent := Self;
   {$ENDREGION}

   {$REGION 'Área do Aviso'}
   RetAviso := TRectangle.Create(Self);
   RetAviso.Fill.Color := TAlphacolors.White;
   RetAviso.Align := TAlignLayout.Center;
   RetAviso.Size.PlatformDefault := False;
   RetAviso.Width := 250;
   RetAviso.Height := 180;
   RetAviso.Stroke.Color := RetAviso.Fill.Color;
   RetAviso.Parent := Self;


   {$ENDREGION}

   {$REGION 'O círculo'}
   Layout1 := TLayout.Create(RetAviso);
   Layout1.Align := TAlignLayout.Top;
   Layout1.Size.Height := 100;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := RetAviso;

   Arc := TArc.Create(Layout1);
   Arc.Align := TAlignLayout.Center;
   Arc.Size.Width := 50;
   Arc.Size.Height := 50;
   Arc.Size.PlatformDefault := False;
   Arc.Stroke.Color := Cor;
   Arc.Stroke.Thickness := 5;
   Arc.StartAngle := 200;
   Arc.EndAngle := 1;
   Arc.Parent := Layout1;
   {$ENDREGION}

   {$REGION 'A Animação do círculo'}
//   Arc.AnimateFloat('EndAngle',
//                   360,
//                   1,
//                   TAnimationType.In,
//                   TInterpolationType.Exponential);

   AnimaArc := TFloatAnimation.Create(Arc);
   AnimaArc.Duration := 0.5;
   AnimaArc.Interpolation := TInterpolationType.Exponential;
   AnimaArc.OnFinish := AnimaArcFinish;
   AnimaArc.PropertyName := 'EndAngle';
   AnimaArc.StartValue := 0;
   AnimaArc.StopValue := 360;
   AnimaArc.Parent := Arc;
   AnimaArc.Start;
   {$ENDREGION}



   {$REGION 'A primeira linha'}
   Layout1 := TLayout.Create(Arc);
   Layout1.Position.X := 8;
   Layout1.Position.Y := 27;
   Layout1.RotationAngle := 45;
   Layout1.Size.Width := 15;
   Layout1.Size.Height := 7;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := Arc;

   Rectangle1 := TRectangle.Create(Layout1);
   Rectangle1.Fill.Color := Cor;
   Rectangle1.Size.Width := 0;
   Rectangle1.Size.Height := 6;
   Rectangle1.Size.PlatformDefault := False;
   Rectangle1.Stroke.Color := cor;
   Rectangle1.XRadius := 3;
   Rectangle1.YRadius := 3;
   Rectangle1.Parent := Layout1;
   {$ENDREGION}

   {$REGION 'A Animação da primeira linha '}
   Anima1 := TFloatAnimation.Create(Rectangle1);
   Anima1.Duration := 0.2;
   Anima1.Interpolation := TInterpolationType.Exponential;
   Anima1.OnFinish := Anima1Finish;
   Anima1.PropertyName := 'Width';
   Anima1.StartValue := 0;
   Anima1.StopValue := 15;
   Anima1.Parent := Rectangle1;
   {$ENDREGION}

   {$REGION 'A segunda linha'}
   Layout1 := TLayout.Create(Arc);
   Layout1.Position.X := 15;
   Layout1.Position.Y := 24;
   Layout1.RotationAngle := -45;
   Layout1.Size.Width := 28;
   Layout1.Size.Height := 7;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := Arc;

   Rectangle1 := TRectangle.Create(Layout1);
   Rectangle1.Fill.Color := Cor;
   Rectangle1.Size.Width := 0;
   Rectangle1.Size.Height := 6;
   Rectangle1.Size.PlatformDefault := False;
   Rectangle1.Stroke.Color := cor;
   Rectangle1.XRadius := 3;
   Rectangle1.YRadius := 3;
   Rectangle1.Parent := Layout1;
   {$ENDREGION}

   {$REGION 'A Animação da 2 linha'}
   Anima2 := TFloatAnimation.Create(Rectangle1);
   Anima2.Duration := 0.1;
   Anima2.Interpolation := TInterpolationType.Exponential;
   Anima2.PropertyName := 'Width';
   Anima2.OnFinish := Anima2Finish;
   Anima2.StartValue := 0;
   Anima2.StopValue := Layout1.Size.Width;
   Anima2.Parent := Rectangle1;
   {$ENDREGION}

   {$REGION 'A mensagem'}
   txt := TText.Create(RetAviso);
   txt.Align := TAlignLayout.Client;
   txt.Size.PlatformDefault := False;
   txt.TextSettings.Font.Size :=14;
   txt.TextSettings.FontColor := Cor;
   txt.Text := Msg;
   txt.Parent := RetAviso;
   {$ENDREGION}

   {$REGION 'Aguardar e desaparece'}
   AnimaSaida := TFloatAnimation.Create(RetAviso);
   AnimaSaida.Duration := 2;
   AnimaSaida.Interpolation := TInterpolationType.Exponential;
   AnimaSaida.OnFinish := AnimaSaidaFinish;
   AnimaSaida.PropertyName := 'Opacity';
   AnimaSaida.StartValue := 1;
   AnimaSaida.StopValue := 1;
   AnimaSaida.Parent := RetAviso;
   {$ENDREGION}

end;


procedure TFormHelper.AvisoNegativo(msg: String; Cor: TAlphaColor);
begin
   RetFundo := TRectangle.Create(Self);

   RetFundo.Fill.Color := TAlphacolors.Black;
   RetFundo.Align := TAlignLayout.Contents;
   RetFundo.Size.PlatformDefault := False;
   RetFundo.Stroke.Color :=  RetFundo.Fill.Color;
   RetFundo.Opacity := 0.1;
   RetFundo.Parent := Self;

   RetAviso := TRectangle.Create(Self);
   RetAviso.Fill.Color := TAlphacolors.White;
   RetAviso.Align := TAlignLayout.Center;
   RetAviso.Size.PlatformDefault := False;
   RetAviso.Width := 250;
   RetAviso.Height := 180;
   RetAviso.Stroke.Color := RetAviso.Fill.Color;
   RetAviso.Parent := Self;

   Cor :=TAlphaColors.Red;

   Layout1 := TLayout.Create(RetAviso);
   Layout1.Align := TAlignLayout.Top;
   Layout1.Size.Height := 100;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := RetAviso;

   Arc := TArc.Create(Layout1);
   Arc.Align := TAlignLayout.Center;
   Arc.Size.Width := 50;
   Arc.Size.Height := 50;
   Arc.Size.PlatformDefault := False;
   Arc.Stroke.Color := Cor;
   Arc.Stroke.Thickness := 5;
   Arc.StartAngle := 200;
   Arc.EndAngle := 1;
   Arc.Parent := Layout1;

   AnimaArc := TFloatAnimation.Create(Arc);
   AnimaArc.Duration := 0.5;
   AnimaArc.Interpolation := TInterpolationType.Exponential;
   AnimaArc.OnFinish := AnimaArcFinish;
   AnimaArc.PropertyName := 'EndAngle';
   AnimaArc.StartValue := 0;
   AnimaArc.StopValue := 360;
   AnimaArc.Parent := Arc;
   AnimaArc.Start;

   Layout1 := TLayout.Create(Arc);
   Layout1.Position.X := 8;
   Layout1.Position.Y := 27;
   Layout1.Align := TAlignLayout.Center;
   Layout1.RotationAngle := 45;
   Layout1.Size.Width := 30;
   Layout1.Size.Height := 7;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := Arc;

   Rectangle1 := TRectangle.Create(Layout1);
   Rectangle1.Fill.Color := Cor;
   Rectangle1.Size.Width := 0;
   Rectangle1.Size.Height := 6;
   Rectangle1.Size.PlatformDefault := False;
   Rectangle1.Stroke.Color := cor;
   Rectangle1.XRadius := 3;
   Rectangle1.YRadius := 3;
   Rectangle1.Parent := Layout1;

   Anima1 := TFloatAnimation.Create(Rectangle1);
   Anima1.Duration := 0.2;
   Anima1.Interpolation := TInterpolationType.Exponential;
   Anima1.OnFinish := Anima1Finish;
   Anima1.PropertyName := 'Width';
   Anima1.StartValue := 0;
   Anima1.StopValue := Layout1.Size.Width;
   Anima1.Parent := Rectangle1;

   Layout1 := TLayout.Create(Arc);
   Layout1.Position.X := 15;
   Layout1.Position.Y := 24;
   Layout1.RotationAngle := -45;
   Layout1.Size.Width := 30;
   Layout1.Size.Height := 7;
   Layout1.Align := TAlignLayout.Center;
   Layout1.Size.PlatformDefault := False;
   Layout1.TabOrder := 0;
   Layout1.Parent := Arc;

   Rectangle1 := TRectangle.Create(Layout1);
   Rectangle1.Fill.Color := Cor;
   Rectangle1.Size.Width := 0;
   Rectangle1.Size.Height := 6;
   Rectangle1.Size.PlatformDefault := False;
   Rectangle1.Stroke.Color := cor;
   Rectangle1.XRadius := 3;
   Rectangle1.YRadius := 3;
   Rectangle1.Parent := Layout1;

   Anima2 := TFloatAnimation.Create(Rectangle1);
   Anima2.Duration := 0.1;
   Anima2.Interpolation := TInterpolationType.Exponential;
   Anima2.PropertyName := 'Width';
   Anima2.OnFinish := Anima2Finish;
   Anima2.StartValue := 0;
   Anima2.StopValue := Layout1.Size.Width;
   Anima2.Parent := Rectangle1;

   AnimaSaida := TFloatAnimation.Create(RetAviso);
   AnimaSaida.Duration := 2;
   AnimaSaida.Interpolation := TInterpolationType.Exponential;
   AnimaSaida.OnFinish := AnimaSaidaFinish;
   AnimaSaida.PropertyName := 'Opacity';
   AnimaSaida.StartValue := 1;
   AnimaSaida.StopValue := 1;
   AnimaSaida.Parent := RetAviso;

   txt := TText.Create(RetAviso);
   txt.Align := TAlignLayout.Client;
   txt.Size.PlatformDefault := False;
   txt.TextSettings.Font.Size :=14;
   txt.TextSettings.FontColor := Cor;
   txt.Text := MSG;
   txt.Parent := RetAviso;



end;

end.
