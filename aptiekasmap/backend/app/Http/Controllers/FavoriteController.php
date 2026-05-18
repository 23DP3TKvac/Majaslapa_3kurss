<?php

namespace App\Http\Controllers;

use App\Models\Favorite;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    public function index(Request $request)
    {
        $favorites = Favorite::with('medicine')
            ->where('user_id', $request->user()->id)
            ->get()
            ->pluck('medicine');
        return response()->json($favorites);
    }

    public function store(Request $request)
    {
        $request->validate(['medicine_id' => 'required|exists:medicines,id']);
        $favorite = Favorite::firstOrCreate([
            'user_id'     => $request->user()->id,
            'medicine_id' => $request->medicine_id,
        ]);
        return response()->json($favorite, 201);
    }

    public function destroy(Request $request, $medicine_id)
    {
        Favorite::where('user_id', $request->user()->id)
            ->where('medicine_id', $medicine_id)
            ->delete();
        return response()->json(['message' => 'Izdzēsts no favorītiem.']);
    }
}
