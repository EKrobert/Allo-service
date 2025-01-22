<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Admin
        User::create([
                'firstname' => 'Admin',
                'lastname' => 'Admin',
                'email' => 'admin2@example.com',
                'phone' => '0987654321',
                'username' => 'admin',
                'role' => 'admin',
                'password' => bcrypt('admin'),
                'created_at' => now(),
                'updated_at' => now(),
        ]);
        
    }
}
