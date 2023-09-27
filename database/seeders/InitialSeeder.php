<?php
namespace Database\Seeders;

use Database\Seeders\Initial\CoreInitialSeeder;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class InitialSeeder extends Seeder
{
    public function run()
    {
        Schema::disableForeignKeyConstraints();
        CoreInitialSeeder::class;
        Schema::enableForeignKeyConstraints();
    }
}
