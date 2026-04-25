import aidocs

def test_main_output(capsys):
    aidocs.main()
    captured = capsys.readouterr()
    assert captured.out == "Hello from aidocs!\n"
