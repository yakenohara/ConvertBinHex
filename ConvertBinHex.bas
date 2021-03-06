Attribute VB_Name = "ConvertBinHex"
'
'Hex文字列からBin文字列を返す
'空文字指定の場合は#VALUE!
'Hex文字列ではない場合は#NUM!を返す
'
Public Function convHexIntToBinInt(ByVal hex As String) As Variant
    
    Dim stringBuilder() As String
    
    On Error GoTo ERR
    
    lenOfHex = Len(hex)
    
    If (lenOfHex = 0) Then
        convHexIntToBinInt = CVErr(xlErrValue) '#VALUE!を返す
        Exit Function
        
    End If
    
    For cnt = 1 To lenOfHex
        
        ReDim Preserve stringBuilder(cnt - 1) '領域拡張
        stringBuilder(cnt - 1) = WorksheetFunction.Hex2Bin(Mid(hex, cnt, 1), 4) '文字列追加
        
    Next cnt
    
    convHexIntToBinInt = Join(stringBuilder, vbNullString) '文字列連結
    Exit Function
    
ERR:
    convHexIntToBinInt = CVErr(xlErrNum) '#NUM!を返却
    Exit Function
    
End Function

'
'Bin文字列からHex文字列を返す
'空文字指定の場合は#VALUE!
'Bin文字列ではない場合は#NUM!を返す
'
Public Function convBinIntToHexInt(ByVal bin As String) As Variant
    
    Dim toConvertBin As String
    Dim stringBuilder() As String
    
    lenOfbin = Len(bin)
    
    If (lenOfbin = 0) Then
        convBinIntToHexInt = CVErr(xlErrValue) '#VALUE!を返す
        Exit Function
        
    End If
    
    modNum = lenOfbin Mod 4
    
    toConvertBin = IIf(modNum = 0, "", String(4 - modNum, "0")) & bin '4文字ずつ処理できる様に0埋め
    
    On Error GoTo ERR
    
    cntMax = Len(toConvertBin)
    For cnt = 1 To cntMax Step 4
        ReDim Preserve stringBuilder(cnt - 1) '領域拡張
        stringBuilder(cnt - 1) = WorksheetFunction.Bin2Hex(Mid(toConvertBin, cnt, 4), 1) '文字列追加
        
    Next cnt
    
    convBinIntToHexInt = Join(stringBuilder, vbNullString)
    Exit Function
    
ERR:
    convBinIntToHexInt = CVErr(xlErrNum) '#NUM!を返却
    Exit Function
    
End Function
