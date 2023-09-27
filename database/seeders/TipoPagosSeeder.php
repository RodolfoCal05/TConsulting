<?php

namespace Database\Seeders;

use App\Models\TConsulting\TipoPago;
use Illuminate\Database\Seeder;

class TipoPagosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TipoPago::truncate();
        TipoPago::insert([
            ['descripcion' => 'Ninguno'],
            ['descripcion' => 'Efectivo'],
            ['descripcion' => 'POS'],
            ['descripcion' => 'Credito'],
        ]);
    }
}
