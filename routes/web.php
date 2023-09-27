<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
 */

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();
Route::group(['middleware' => ['auth']], function () {
    Route::resource('profile', 'ProfileController', ['only' => ['index', 'detail', 'store']]);
});

Route::group(['middleware' => ['auth', 'cancerbero']], function () {
    Route::get('/', ['as' => 'index.index', 'uses' => 'HomeController@index']);

    Route::namespace('RRHH')->prefix('rrhh')->name('rrhh.')->group(function(){
        Route::resource('empleados', 'EmpleadosController', ['only' => ['index', 'edit', 'store', 'detail', 'update']]);
    });

    Route::namespace ('Productos')->prefix('productos')->name('productos.')->group(function () {
        Route::resource('lista-productos', 'ListaProductosController');
        Route::resource('precios', 'PreciosController');
        Route::resource('ofertas', 'OfertasController');
        Route::resource('lotes', 'LotesController');
    });

    Route::namespace ('Inventarios')->prefix('inventarios')->name('inventarios.')->group(function () {
        Route::resource('sucursales', 'SucursalesController', ['only' => ['index', 'update', 'edit', 'data', 'store', 'create']]);
        Route::resource('lote-inventario', 'LoteInventarioController', ['only' => ['index', 'update', 'edit', 'data']]);
    });

    Route::namespace ('Socios')->prefix('socios')->name('socios.')->group(function () {
        Route::resource('listado-socios', 'ListadoSociosController');
    });

    Route::namespace ('Suministros')->prefix('suministros')->name('suministros.')->group(function () {
        Route::resource('gestiones', 'GestionesController', ['only' => ['index', 'edit', 'store', 'detail']]);
        Route::resource('transacciones', 'TransaccionesController', ['only' => ['index', 'data']]);
    });

    Route::namespace ('Catalogs')->prefix('catalogs')->name('catalogs.')->group(function () {
        Route::resource('users', 'UsersController');
        Route::resource('roles', 'RolesController');
        Route::resource('control-accesos', 'ControlAccesosController', ['only' => ['index', 'detail', 'store']]);
    });
});