<?php

namespace Database\Seeders;

use App\Models\Ventas\VentaComisione;
use Illuminate\Database\Seeder;

class VentaComisiones extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        VentaComisione::truncate();
        VentaComisione::insert([
            ['descripcion' => 'Bajo', 'monto_inicio' => 0, 'monto_fin' => 100000, 'porcentaje' => 0.0],
            ['descripcion' => 'Medio-Bajo', 'monto_inicio' => 100001, 'monto_fin' => 200000, 'porcentaje' => 2.5],
            ['descripcion' => 'Medio', 'monto_inicio' => 200001, 'monto_fin' => 400000, 'porcentaje' => 3.5],
            ['descripcion' => 'Alto', 'monto_inicio' => 400001, 'monto_fin' => 10000000, 'porcentaje' => 4.5],
        ]);
    }
}
