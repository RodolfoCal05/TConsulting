<?php
namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();
        $this->call([
            ModulesSeeder::class,
            PermissionsSeeder::class,
            ModulePermissionsSeeder::class,
            MenuSeeder::class,
            TipoSedesSeeder::class,
            TipoPagosSeeder::class,
            TipoSociosSeeder::class,
            SeriesSeeder::class,
            FidelizacionesSeeder::class,
            VentaComisiones::class,
            TipoFamiliasSeeder::class,
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
