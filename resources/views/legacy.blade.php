@extends('layouts/app')
@section('title')
{{ $titulo }}
@stop
@section('content')
<iframe name="X-Frame-Options" value="SAMEORIGIN" src="{{$url}}" id="frame" name="frame" style="overflow:hidden;width:100%; min-height: 700px; border: 0;"></iframe>
@stop
