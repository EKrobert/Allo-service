<?php

namespace App\Http\Controllers;

use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ServicesController extends Controller
{



    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $services = Service::all();
        return view('servicesLayout.servicelist', compact('services'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('servicesLayout.addservice');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|unique:services',
        ]);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors())->withInput();
        }
        try {
            $data = $request->all();
            Service::create($data);
            return redirect()->route('services.index');
        } catch (\Throwable $th) {
            return back()->withError($th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  Service  $service
     * @return \Illuminate\Http\Response
     */
    public function show(Service $service)
    {
        
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  Service  $service
     * @return \Illuminate\Http\Response
     */
    public function edit(Service $service)
    {
        
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  Service  $service
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Service $service)
    {
        $validator = Validator::make($request->all(), [
            'libelle' => 'required|string|unique:services,libelle,' . $service->id,
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors())->withInput();
        }

        try {
            $data = $request->all();
            $service->update($data);
            return redirect()->route('services.index');
        } catch (\Throwable $th) {
            return back()->withError($th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  Service  $service
     * @return \Illuminate\Http\Response
     */
    public function destroy(Service $service)
    {
        
    }
}
