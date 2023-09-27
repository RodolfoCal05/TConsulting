<?php

/*
|--------------------------------------------------------------------------
| Console Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of your Closure based console
| commands. Each Closure is bound to a command instance allowing a
| simple approach to interacting with each command's IO methods.
|
 */

use App\Models\Auth\User;
use App\Models\TConsulting\Ascenso;
use App\Models\TConsulting\Puesto;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Hash;

Artisan::command('password', function(){
    dd(Hash::make('admin'));
});

Artisan::command('user', function(){
    $user = auth()->user()->id;
    dd($user);
});

Artisan::command('calculos',function(){


});


