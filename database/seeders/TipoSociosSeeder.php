<?php

namespace Database\Seeders;

use App\Models\TConsulting\TipoSocio;
use Illuminate\Database\Seeder;

class TipoSociosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TipoSocio::truncate();
        TipoSocio::insert([
            ['descripcion' => 'Cliente'],
            ['descripcion' => 'Proveedor'],
            ['descripcion' => 'Colaborador'],
        ]);
    }
}
