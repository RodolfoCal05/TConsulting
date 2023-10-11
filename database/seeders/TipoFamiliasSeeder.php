<?php

namespace Database\Seeders;

use App\Models\TConsulting\TipoFamilia;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class TipoFamiliasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();

        TipoFamilia::truncate();
        TipoFamilia::insert([
            ['descripcion' => 'progenie'],
            ['descripcion' => 'conyuge'],
        ]);

        Schema::enableForeignKeyConstraints();
    }
}
