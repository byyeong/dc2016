<?

/*

    TF External Apps
    Name: tf_welcome
    Author: Binseop Ko
    Description: Trail welcome pack.
    
    Version: 2011-06-14
    VersionMin: 0.8.0
    VersionMax: -
    

*/

    include_once("../tf_app/ext/tf_welcome/controller.php");    

    $trail->add_ext_route("tf", "*component*/tf_welcome/index");
    $trail->add_ext_route("tf/diagnotics", "*component*/tf_welcome/diagnotics");
    $trail->add_ext_route("tf/make_ultra_project", "*component*/tf_welcome/make_ultra_project");
    $trail->add_ext_route("tf/make_ultra_project_write", "*component*/tf_welcome/make_ultra_project_write");
    $trail->add_ext_route("tf/make_ultra_project_download", "*component*/tf_welcome/make_ultra_project_download");

    $trail->add_ext_route("tf/remedy/%1", "*component*/tf_welcome/remedy/%1");
    $trail->add_ext_route("tf/doc", "*component*/tf_welcome/docs");
    $trail->add_ext_route("tf/doc/%1", "*component*/tf_welcome/docs/%1");
    $trail->add_ext_route("tf/doc/%1/%2", "*component*/tf_welcome/docs/%1/%2");
    $trail->add_ext_route("tf/doc/%1/%2/%3", "*component*/tf_welcome/docs/%1/%2/%3");

     
?>
