<?php

namespace Database\Seeders;

use App\Models\TConsulting\TipoSede;
use Illuminate\Database\Seeder;

class TipoSedesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TipoSede::truncate();
        TipoSede::insert([
            ['descripcion' => 'Supermercado'],
            ['descripcion' => 'Tienda de Mayoreo'],
            ['descripcion' => 'Bodega Central'],
        ]);
    }
}
