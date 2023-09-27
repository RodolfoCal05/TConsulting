<?php

namespace Database\Seeders;

use App\Models\TConsulting\Serie;
use Illuminate\Database\Seeder;

class SeriesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Serie::truncate();
        Serie::insert([
            ['descripcion' => 'VENTA'],
            ['descripcion' => 'TRASLADO'],
            ['descripcion' => 'COMPRA'],
            ['descripcion' => 'RECEPCION'],
            ['descripcion' => 'RRHH'],
        ]);
    }
}
