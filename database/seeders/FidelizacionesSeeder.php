<?php

namespace Database\Seeders;

use App\Models\TConsulting\Fidelizacion;
use Illuminate\Database\Seeder;

class FidelizacionesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Fidelizacion::truncate();
        Fidelizacion::insert([
            ['descripcion' => 'Descuento', 'valor' => 0.15],
            ['descripcion' => 'Cupon', 'valor' => 0.05],
            ['descripcion' => 'Promocion', 'valor' => 0.1],
            ['descripcion' => 'Ninguno', 'valor' => 0],
        ]);
    }
}
